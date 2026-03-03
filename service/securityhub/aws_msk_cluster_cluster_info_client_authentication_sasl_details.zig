const AwsMskClusterClusterInfoClientAuthenticationSaslIamDetails = @import("aws_msk_cluster_cluster_info_client_authentication_sasl_iam_details.zig").AwsMskClusterClusterInfoClientAuthenticationSaslIamDetails;
const AwsMskClusterClusterInfoClientAuthenticationSaslScramDetails = @import("aws_msk_cluster_cluster_info_client_authentication_sasl_scram_details.zig").AwsMskClusterClusterInfoClientAuthenticationSaslScramDetails;

/// Provides details for client authentication using SASL.
pub const AwsMskClusterClusterInfoClientAuthenticationSaslDetails = struct {
    /// Provides details for SASL client authentication using IAM.
    iam: ?AwsMskClusterClusterInfoClientAuthenticationSaslIamDetails = null,

    /// Details for SASL client authentication using SCRAM.
    scram: ?AwsMskClusterClusterInfoClientAuthenticationSaslScramDetails = null,

    pub const json_field_names = .{
        .iam = "Iam",
        .scram = "Scram",
    };
};
