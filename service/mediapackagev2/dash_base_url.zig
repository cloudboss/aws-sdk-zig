/// The base URLs to use for retrieving segments. You can specify multiple
/// locations and indicate the priority and weight for when each should be used,
/// for use in mutli-CDN workflows.
pub const DashBaseUrl = struct {
    /// For use with DVB-DASH profiles only. The priority of this location for
    /// servings segments. The lower the number, the higher the priority.
    dvb_priority: ?i32 = null,

    /// For use with DVB-DASH profiles only. The weighting for source locations that
    /// have the same priority.
    dvb_weight: ?i32 = null,

    /// The name of the source location.
    service_location: ?[]const u8 = null,

    /// A source location for segments.
    url: []const u8,

    pub const json_field_names = .{
        .dvb_priority = "DvbPriority",
        .dvb_weight = "DvbWeight",
        .service_location = "ServiceLocation",
        .url = "Url",
    };
};
