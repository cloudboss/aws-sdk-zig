pub const IpamPoolCidrState = enum {
    pending_provision,
    provisioned,
    failed_provision,
    pending_deprovision,
    deprovisioned,
    failed_deprovision,
    pending_import,
    failed_import,
};
