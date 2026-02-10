pub const AsnState = enum {
    deprovisioned,
    failed_deprovision,
    failed_provision,
    pending_deprovision,
    pending_provision,
    provisioned,
};
