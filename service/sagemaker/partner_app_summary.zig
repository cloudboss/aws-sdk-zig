const PartnerAppStatus = @import("partner_app_status.zig").PartnerAppStatus;
const PartnerAppType = @import("partner_app_type.zig").PartnerAppType;

/// A subset of information related to a SageMaker Partner AI App. This
/// information is used as part of the `ListPartnerApps` API response.
pub const PartnerAppSummary = struct {
    /// The ARN of the SageMaker Partner AI App.
    arn: ?[]const u8 = null,

    /// The creation time of the SageMaker Partner AI App.
    creation_time: ?i64 = null,

    /// The name of the SageMaker Partner AI App.
    name: ?[]const u8 = null,

    /// The status of the SageMaker Partner AI App.
    status: ?PartnerAppStatus = null,

    /// The type of SageMaker Partner AI App to create. Must be one of the
    /// following: `lakera-guard`, `comet`, `deepchecks-llm-evaluation`, or
    /// `fiddler`.
    @"type": ?PartnerAppType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .name = "Name",
        .status = "Status",
        .@"type" = "Type",
    };
};
