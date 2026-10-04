const LogType = @import("log_type.zig").LogType;

/// The configuration parameters for log delivery, including `logType` settings.
/// Applies to resource types that support configurable log delivery, such as
/// Amazon Bedrock Knowledge Bases, Amazon Bedrock AgentCore payment managers,
/// and Elastic Load Balancing Application Load Balancers.
pub const LogDeliveryParameters = struct {
    /// The types of logs to collect from the resource.
    log_types: ?[]const LogType = null,

    pub const json_field_names = .{
        .log_types = "LogTypes",
    };
};
