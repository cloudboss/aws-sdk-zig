/// A structure that contains identifying information for a CloudWatch
/// Synthetics canary entity used in audit targeting.
pub const CanaryEntity = struct {
    /// The name of the CloudWatch Synthetics canary.
    canary_name: []const u8,

    pub const json_field_names = .{
        .canary_name = "CanaryName",
    };
};
