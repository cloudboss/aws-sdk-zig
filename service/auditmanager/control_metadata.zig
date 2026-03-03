/// The metadata that's associated with the standard control or custom control.
pub const ControlMetadata = struct {
    /// The Amazon Resource Name (ARN) of the control.
    arn: ?[]const u8 = null,

    /// The data source that determines where Audit Manager collects evidence from
    /// for the
    /// control.
    control_sources: ?[]const u8 = null,

    /// The time when the control was created.
    created_at: ?i64 = null,

    /// The unique identifier for the control.
    id: ?[]const u8 = null,

    /// The time when the control was most recently updated.
    last_updated_at: ?i64 = null,

    /// The name of the control.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .control_sources = "controlSources",
        .created_at = "createdAt",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
    };
};
