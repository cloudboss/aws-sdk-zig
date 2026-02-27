/// This structure contains information about one investigation group in the
/// account.
pub const ListInvestigationGroupsModel = struct {
    /// The Amazon Resource Name (ARN) of the investigation group.
    arn: ?[]const u8,

    /// The name of the investigation group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
