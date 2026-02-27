/// Item in a list of mission profiles.
pub const MissionProfileListItem = struct {
    /// ARN of a mission profile.
    mission_profile_arn: ?[]const u8,

    /// UUID of a mission profile.
    mission_profile_id: ?[]const u8,

    /// Name of a mission profile.
    name: ?[]const u8,

    /// Region of a mission profile.
    region: ?[]const u8,

    pub const json_field_names = .{
        .mission_profile_arn = "missionProfileArn",
        .mission_profile_id = "missionProfileId",
        .name = "name",
        .region = "region",
    };
};
