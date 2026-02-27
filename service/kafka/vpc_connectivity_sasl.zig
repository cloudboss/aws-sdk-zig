const VpcConnectivityIam = @import("vpc_connectivity_iam.zig").VpcConnectivityIam;
const VpcConnectivityScram = @import("vpc_connectivity_scram.zig").VpcConnectivityScram;

/// Details for SASL client authentication for VPC connectivity.
pub const VpcConnectivitySasl = struct {
    /// Details for SASL/IAM client authentication for VPC connectivity.
    iam: ?VpcConnectivityIam,

    /// Details for SASL/SCRAM client authentication for VPC connectivity.
    scram: ?VpcConnectivityScram,

    pub const json_field_names = .{
        .iam = "Iam",
        .scram = "Scram",
    };
};
