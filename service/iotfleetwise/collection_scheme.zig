const ConditionBasedCollectionScheme = @import("condition_based_collection_scheme.zig").ConditionBasedCollectionScheme;
const TimeBasedCollectionScheme = @import("time_based_collection_scheme.zig").TimeBasedCollectionScheme;

/// Specifies what data to collect and how often or when to collect it.
pub const CollectionScheme = union(enum) {
    /// Information about a collection scheme that uses a simple logical expression
    /// to
    /// recognize what data to collect.
    condition_based_collection_scheme: ?ConditionBasedCollectionScheme,
    /// Information about a collection scheme that uses a time period to decide how
    /// often to
    /// collect data.
    time_based_collection_scheme: ?TimeBasedCollectionScheme,

    pub const json_field_names = .{
        .condition_based_collection_scheme = "conditionBasedCollectionScheme",
        .time_based_collection_scheme = "timeBasedCollectionScheme",
    };
};
