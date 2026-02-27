const ListServiceInstancesFilterBy = @import("list_service_instances_filter_by.zig").ListServiceInstancesFilterBy;

/// A filtering criterion to scope down the result list of the
/// ListServiceInstances action.
pub const ListServiceInstancesFilter = struct {
    /// The name of a filtering criterion.
    key: ?ListServiceInstancesFilterBy,

    /// A value to filter by.
    ///
    /// With the date/time keys (`*At{Before,After}`), the value is a valid [RFC
    /// 3339](https://datatracker.ietf.org/doc/html/rfc3339.html) string with no UTC
    /// offset and with an optional fractional precision (for example,
    /// `1985-04-12T23:20:50.52Z`).
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
