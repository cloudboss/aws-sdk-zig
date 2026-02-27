/// A source resource can be a source server, a migration wave, an application,
/// or any other
/// resource that you track.
pub const SourceResource = struct {
    /// A description that can be free-form text to record additional detail about
    /// the resource
    /// for clarity or later reference.
    description: ?[]const u8,

    /// This is the name that you want to use to identify the resource. If the
    /// resource is an
    /// AWS resource, we recommend that you set this parameter to the ARN of the
    /// resource.
    name: []const u8,

    /// A free-form description of the status of the resource.
    status_detail: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .status_detail = "StatusDetail",
    };
};
