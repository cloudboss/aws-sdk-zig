/// A lifecycle event for an Amazon Web Services service version, such as
/// end-of-support or end-of-life.
pub const LifecycleEvent = struct {
    /// The date of the lifecycle event.
    date: ?i64 = null,

    /// A description of the lifecycle event.
    description: ?[]const u8 = null,

    /// The potential impact risks associated with this lifecycle event.
    impact_risks: ?[]const []const u8 = null,

    /// The type of lifecycle event (for example, end-of-support, end-of-life).
    lifecycle_event_type: ?[]const u8 = null,

    /// The Amazon Web Services Regions affected by this lifecycle event.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .date = "date",
        .description = "description",
        .impact_risks = "impactRisks",
        .lifecycle_event_type = "lifecycleEventType",
        .regions = "regions",
    };
};
