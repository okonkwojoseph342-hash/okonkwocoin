;; title: Okonkwocoin (OKC)
;; version: 1.0.0
;; summary: A SIP-010 compliant fungible token named after Chinua Achebe's Okonkwo
;; description: Okonkwocoin represents strength and determination in the Stacks ecosystem

;; traits
;; SIP-010 trait will be implemented when deployed to mainnet
;; (impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; token definitions
(define-fungible-token okonkwocoin)

;; constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant TOKEN-NAME "Okonkwocoin")
(define-constant TOKEN-SYMBOL "OKC")
(define-constant TOKEN-DECIMALS u6)
(define-constant TOTAL-SUPPLY u100000000000000) ;; 100 million tokens with 6 decimals

;; Error codes
(define-constant ERR-OWNER-ONLY (err u100))
(define-constant ERR-NOT-TOKEN-OWNER (err u101))
(define-constant ERR-INSUFFICIENT-BALANCE (err u102))
(define-constant ERR-INVALID-AMOUNT (err u103))
(define-constant ERR-UNAUTHORIZED (err u104))

;; data vars
(define-data-var token-uri (optional (string-utf8 256)) none)
(define-data-var contract-paused bool false)

;; data maps
(define-map authorized-minters principal bool)

;; Initialize contract with total supply to contract owner
(ft-mint? okonkwocoin TOTAL-SUPPLY CONTRACT-OWNER)

;; public functions

;; SIP-010 Functions

;; Get token name
(define-read-only (get-name)
  (ok TOKEN-NAME))

;; Get token symbol  
(define-read-only (get-symbol)
  (ok TOKEN-SYMBOL))

;; Get token decimals
(define-read-only (get-decimals)
  (ok TOKEN-DECIMALS))

;; Get balance of a principal
(define-read-only (get-balance (who principal))
  (ok (ft-get-balance okonkwocoin who)))

;; Get total supply
(define-read-only (get-total-supply)
  (ok (ft-get-supply okonkwocoin)))

;; Get token URI
(define-read-only (get-token-uri)
  (ok (var-get token-uri)))

;; Transfer tokens
(define-public (transfer (amount uint) (from principal) (to principal) (memo (optional (buff 34))))
  (begin
    (asserts! (not (var-get contract-paused)) ERR-UNAUTHORIZED)
    (asserts! (or (is-eq from tx-sender) (is-eq from contract-caller)) ERR-NOT-TOKEN-OWNER)
    (asserts! (> amount u0) ERR-INVALID-AMOUNT)
    (try! (ft-transfer? okonkwocoin amount from to))
    (match memo to-print (print to-print) 0x)
    (print {action: "transfer", from: from, to: to, amount: amount})
    (ok true)))

;; Mint new tokens (only authorized minters)
(define-public (mint (amount uint) (to principal))
  (begin
    (asserts! (or (is-eq tx-sender CONTRACT-OWNER) 
                  (default-to false (map-get? authorized-minters tx-sender))) ERR-UNAUTHORIZED)
    (asserts! (> amount u0) ERR-INVALID-AMOUNT)
    (asserts! (not (var-get contract-paused)) ERR-UNAUTHORIZED)
    (try! (ft-mint? okonkwocoin amount to))
    (print {action: "mint", to: to, amount: amount})
    (ok true)))

;; Burn tokens
(define-public (burn (amount uint) (from principal))
  (begin
    (asserts! (or (is-eq from tx-sender) (is-eq from contract-caller)) ERR-NOT-TOKEN-OWNER)
    (asserts! (> amount u0) ERR-INVALID-AMOUNT)
    (try! (ft-burn? okonkwocoin amount from))
    (print {action: "burn", from: from, amount: amount})
    (ok true)))

;; Administrative functions

;; Set token URI (owner only)
(define-public (set-token-uri (new-uri (optional (string-utf8 256))))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-OWNER-ONLY)
    (var-set token-uri new-uri)
    (ok true)))

;; Pause/unpause contract (owner only)
(define-public (set-contract-paused (paused bool))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-OWNER-ONLY)
    (var-set contract-paused paused)
    (ok true)))

;; Add authorized minter (owner only)
(define-public (add-minter (minter principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-OWNER-ONLY)
    (map-set authorized-minters minter true)
    (ok true)))

;; Remove authorized minter (owner only)
(define-public (remove-minter (minter principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-OWNER-ONLY)
    (map-delete authorized-minters minter)
    (ok true)))

;; read only functions

;; Check if principal is authorized minter
(define-read-only (is-authorized-minter (who principal))
  (default-to false (map-get? authorized-minters who)))

;; Check if contract is paused
(define-read-only (is-contract-paused)
  (var-get contract-paused))

;; Get contract owner
(define-read-only (get-contract-owner)
  CONTRACT-OWNER)

;; private functions
;; (None currently needed)

