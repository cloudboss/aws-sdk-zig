const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// Describes an application resource that represents a collection of content
/// for streaming with Amazon GameLift Streams. To retrieve additional
/// application details, call
/// [GetApplication](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetApplication.html).
pub const ApplicationSummary = struct {
    /// An Amazon Resource Name (ARN) that's assigned to an application resource and
    /// uniquely identifies the application across all Amazon Web Services Regions.
    /// Format is `arn:aws:gameliftstreams:[AWS Region]:[AWS
    /// account]:application/[resource ID]`.
    arn: []const u8,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64,

    /// A human-readable label for the application. You can edit this value.
    description: ?[]const u8,

    /// An ID that uniquely identifies the application resource. Example ID:
    /// `a-9ZY8X7Wv6`.
    id: ?[]const u8,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64,

    /// Configuration settings that identify the operating system for an application
    /// resource. This can also include a compatibility layer and other drivers.
    ///
    /// A runtime environment can be one of the following:
    ///
    /// * For Linux applications
    ///
    /// * Ubuntu 22.04 LTS (`Type=UBUNTU, Version=22_04_LTS`)
    ///
    /// * For Windows applications
    ///
    /// * Microsoft Windows Server 2022 Base (`Type=WINDOWS, Version=2022`)
    /// * Proton 9.0-2 (`Type=PROTON, Version=20250516`)
    /// * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    /// * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    runtime_environment: ?RuntimeEnvironment,

    /// The current status of the application resource. Possible statuses include
    /// the following:
    ///
    /// * `INITIALIZED`: Amazon GameLift Streams has received the request and is
    ///   initiating the work flow to create an application.
    /// * `PROCESSING`: The create application work flow is in process. Amazon
    ///   GameLift Streams is copying the content and caching for future deployment
    ///   in a stream group.
    /// * `READY`: The application is ready to deploy in a stream group.
    /// * `ERROR`: An error occurred when setting up the application. For more
    ///   information about the error, call `GetApplication` and refer to
    ///   `StatusReason`.
    /// * `DELETING`: Amazon GameLift Streams is in the process of deleting the
    ///   application.
    status: ?ApplicationStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .last_updated_at = "LastUpdatedAt",
        .runtime_environment = "RuntimeEnvironment",
        .status = "Status",
    };
};
