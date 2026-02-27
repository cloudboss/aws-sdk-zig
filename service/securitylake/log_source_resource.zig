const AwsLogSourceResource = @import("aws_log_source_resource.zig").AwsLogSourceResource;
const CustomLogSourceResource = @import("custom_log_source_resource.zig").CustomLogSourceResource;

/// The supported source types from which logs and events are collected in
/// Amazon Security Lake.
/// For a list of supported Amazon Web Services services, see the [Amazon
/// Security Lake User
/// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/internal-sources.html).
pub const LogSourceResource = union(enum) {
    /// Amazon Security Lake supports log and event collection for natively
    /// supported Amazon Web Services services. For more information, see the
    /// [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/internal-sources.html).
    aws_log_source: ?AwsLogSourceResource,
    /// Amazon Security Lake supports custom source types. For more information, see
    /// the [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/custom-sources.html).
    custom_log_source: ?CustomLogSourceResource,

    pub const json_field_names = .{
        .aws_log_source = "awsLogSource",
        .custom_log_source = "customLogSource",
    };
};
