;; Okonkwobit fungible token contract
;; Minimal owner-controlled mint and standard transfer

(define-fungible-token okonkwobit)

(define-data-var owner principal tx-sender)

(define-constant err-unauthorized u403)

(define-read-only (get-owner)
  (ok (var-get owner)))

(define-public (set-owner (new-owner principal))
  (if (is-eq tx-sender (var-get owner))
      (begin
        (var-set owner new-owner)
        (ok true))
      (err err-unauthorized)))

(define-read-only (get-balance (who principal))
  (ok (ft-get-balance okonkwobit who)))

(define-read-only (get-total-supply)
  (ok (ft-get-supply okonkwobit)))

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (if (is-eq tx-sender sender)
      (ft-transfer? okonkwobit amount sender recipient)
      (err err-unauthorized)))

(define-public (mint (amount uint) (recipient principal))
  (if (is-eq tx-sender (var-get owner))
      (ft-mint? okonkwobit amount recipient)
      (err err-unauthorized)))
