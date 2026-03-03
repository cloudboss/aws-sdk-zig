const ShareRequestStatus = @import("share_request_status.zig").ShareRequestStatus;

/// Represents a share request for a custom framework in Audit Manager.
pub const AssessmentFrameworkShareRequest = struct {
    /// An optional comment from the sender about the share request.
    comment: ?[]const u8 = null,

    /// The compliance type that the shared custom framework supports, such as CIS
    /// or
    /// HIPAA.
    compliance_type: ?[]const u8 = null,

    /// The time when the share request was created.
    creation_time: ?i64 = null,

    /// The number of custom controls that are part of the shared custom framework.
    custom_controls_count: ?i32 = null,

    /// The Amazon Web Services account of the recipient.
    destination_account: ?[]const u8 = null,

    /// The Amazon Web Services Region of the recipient.
    destination_region: ?[]const u8 = null,

    /// The time when the share request expires.
    expiration_time: ?i64 = null,

    /// The description of the shared custom framework.
    framework_description: ?[]const u8 = null,

    /// The unique identifier for the shared custom framework.
    framework_id: ?[]const u8 = null,

    /// The name of the custom framework that the share request is for.
    framework_name: ?[]const u8 = null,

    /// The unique identifier for the share request.
    id: ?[]const u8 = null,

    /// Specifies when the share request was last updated.
    last_updated: ?i64 = null,

    /// The Amazon Web Services account of the sender.
    source_account: ?[]const u8 = null,

    /// The number of standard controls that are part of the shared custom
    /// framework.
    standard_controls_count: ?i32 = null,

    /// The status of the share request.
    status: ?ShareRequestStatus = null,

    pub const json_field_names = .{
        .comment = "comment",
        .compliance_type = "complianceType",
        .creation_time = "creationTime",
        .custom_controls_count = "customControlsCount",
        .destination_account = "destinationAccount",
        .destination_region = "destinationRegion",
        .expiration_time = "expirationTime",
        .framework_description = "frameworkDescription",
        .framework_id = "frameworkId",
        .framework_name = "frameworkName",
        .id = "id",
        .last_updated = "lastUpdated",
        .source_account = "sourceAccount",
        .standard_controls_count = "standardControlsCount",
        .status = "status",
    };
};
