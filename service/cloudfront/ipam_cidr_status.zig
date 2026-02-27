pub const IpamCidrStatus = enum {
    provisioned,
    failed_provision,
    provisioning,
    deprovisioned,
    failed_deprovision,
    deprovisioning,
    advertised,
    failed_advertise,
    advertising,
    withdrawn,
    failed_withdraw,
    withdrawing,
};
