pub const ByoipCidrState = enum {
    advertised,
    deprovisioned,
    failed_deprovision,
    failed_provision,
    pending_advertising,
    pending_deprovision,
    pending_provision,
    pending_withdrawal,
    provisioned,
    provisioned_not_publicly_advertisable,
};
