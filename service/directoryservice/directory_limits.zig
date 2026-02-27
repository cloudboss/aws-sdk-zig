/// Contains directory limit information for a Region.
pub const DirectoryLimits = struct {
    /// The current number of cloud directories in the Region.
    cloud_only_directories_current_count: ?i32,

    /// The maximum number of cloud directories allowed in the Region.
    cloud_only_directories_limit: ?i32,

    /// Indicates if the cloud directory limit has been reached.
    cloud_only_directories_limit_reached: bool = false,

    /// The current number of Managed Microsoft AD directories in the region.
    cloud_only_microsoft_ad_current_count: ?i32,

    /// The maximum number of Managed Microsoft AD directories allowed in the
    /// region.
    cloud_only_microsoft_ad_limit: ?i32,

    /// Indicates if the Managed Microsoft AD directory limit has been reached.
    cloud_only_microsoft_ad_limit_reached: bool = false,

    /// The current number of connected directories in the Region.
    connected_directories_current_count: ?i32,

    /// The maximum number of connected directories allowed in the Region.
    connected_directories_limit: ?i32,

    /// Indicates if the connected directory limit has been reached.
    connected_directories_limit_reached: bool = false,

    pub const json_field_names = .{
        .cloud_only_directories_current_count = "CloudOnlyDirectoriesCurrentCount",
        .cloud_only_directories_limit = "CloudOnlyDirectoriesLimit",
        .cloud_only_directories_limit_reached = "CloudOnlyDirectoriesLimitReached",
        .cloud_only_microsoft_ad_current_count = "CloudOnlyMicrosoftADCurrentCount",
        .cloud_only_microsoft_ad_limit = "CloudOnlyMicrosoftADLimit",
        .cloud_only_microsoft_ad_limit_reached = "CloudOnlyMicrosoftADLimitReached",
        .connected_directories_current_count = "ConnectedDirectoriesCurrentCount",
        .connected_directories_limit = "ConnectedDirectoriesLimit",
        .connected_directories_limit_reached = "ConnectedDirectoriesLimitReached",
    };
};
