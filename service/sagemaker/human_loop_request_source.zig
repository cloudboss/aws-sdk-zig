const AwsManagedHumanLoopRequestSource = @import("aws_managed_human_loop_request_source.zig").AwsManagedHumanLoopRequestSource;

/// Container for configuring the source of human task requests.
pub const HumanLoopRequestSource = struct {
    /// Specifies whether Amazon Rekognition or Amazon Textract are used as the
    /// integration source. The default field settings and JSON parsing rules are
    /// different based on the integration source. Valid values:
    aws_managed_human_loop_request_source: AwsManagedHumanLoopRequestSource,

    pub const json_field_names = .{
        .aws_managed_human_loop_request_source = "AwsManagedHumanLoopRequestSource",
    };
};
