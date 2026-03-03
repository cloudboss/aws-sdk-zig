const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// The filter used to determine which endpoints are returned. You can filter
/// jobs on their
/// name, model, status, or the date and time that they were created. You can
/// only set one filter
/// at a time.
pub const EndpointFilter = struct {
    /// Specifies a date after which the returned endpoint or endpoints were
    /// created.
    creation_time_after: ?i64 = null,

    /// Specifies a date before which the returned endpoint or endpoints were
    /// created.
    creation_time_before: ?i64 = null,

    /// The Amazon Resource Number (ARN) of the model to which the endpoint is
    /// attached.
    model_arn: ?[]const u8 = null,

    /// Specifies the status of the endpoint being returned. Possible values are:
    /// Creating, Ready,
    /// Updating, Deleting, Failed.
    status: ?EndpointStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .model_arn = "ModelArn",
        .status = "Status",
    };
};
