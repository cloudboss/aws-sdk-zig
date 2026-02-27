const ComputePlatform = @import("compute_platform.zig").ComputePlatform;

/// Information about an application.
pub const ApplicationInfo = struct {
    /// The application ID.
    application_id: ?[]const u8,

    /// The application name.
    application_name: ?[]const u8,

    /// The destination platform type for deployment of the application (`Lambda` or
    /// `Server`).
    compute_platform: ?ComputePlatform,

    /// The time at which the application was created.
    create_time: ?i64,

    /// The name for a connection to a GitHub account.
    git_hub_account_name: ?[]const u8,

    /// True if the user has authenticated with GitHub for the specified
    /// application.
    /// Otherwise, false.
    linked_to_git_hub: bool = false,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_name = "applicationName",
        .compute_platform = "computePlatform",
        .create_time = "createTime",
        .git_hub_account_name = "gitHubAccountName",
        .linked_to_git_hub = "linkedToGitHub",
    };
};
