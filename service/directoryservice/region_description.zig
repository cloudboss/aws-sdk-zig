const RegionType = @import("region_type.zig").RegionType;
const DirectoryStage = @import("directory_stage.zig").DirectoryStage;
const DirectoryVpcSettings = @import("directory_vpc_settings.zig").DirectoryVpcSettings;

/// The replicated Region information for a directory.
pub const RegionDescription = struct {
    /// The desired number of domain controllers in the specified Region for the
    /// specified
    /// directory.
    desired_number_of_domain_controllers: ?i32,

    /// The identifier of the directory.
    directory_id: ?[]const u8,

    /// The date and time that the Region description was last updated.
    last_updated_date_time: ?i64,

    /// Specifies when the Region replication began.
    launch_time: ?i64,

    /// The name of the Region. For example, `us-east-1`.
    region_name: ?[]const u8,

    /// Specifies whether the Region is the primary Region or an additional Region.
    region_type: ?RegionType,

    /// The status of the replication process for the specified Region.
    status: ?DirectoryStage,

    /// The date and time that the Region status was last updated.
    status_last_updated_date_time: ?i64,

    vpc_settings: ?DirectoryVpcSettings,

    pub const json_field_names = .{
        .desired_number_of_domain_controllers = "DesiredNumberOfDomainControllers",
        .directory_id = "DirectoryId",
        .last_updated_date_time = "LastUpdatedDateTime",
        .launch_time = "LaunchTime",
        .region_name = "RegionName",
        .region_type = "RegionType",
        .status = "Status",
        .status_last_updated_date_time = "StatusLastUpdatedDateTime",
        .vpc_settings = "VpcSettings",
    };
};
