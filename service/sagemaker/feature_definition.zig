const CollectionConfig = @import("collection_config.zig").CollectionConfig;
const CollectionType = @import("collection_type.zig").CollectionType;
const FeatureType = @import("feature_type.zig").FeatureType;

/// A list of features. You must include `FeatureName` and `FeatureType`. Valid
/// feature `FeatureType`s are `Integral`, `Fractional` and `String`.
pub const FeatureDefinition = struct {
    /// Configuration for your collection.
    collection_config: ?CollectionConfig,

    /// A grouping of elements where each element within the collection must have
    /// the same feature type (`String`, `Integral`, or `Fractional`).
    ///
    /// * `List`: An ordered collection of elements.
    /// * `Set`: An unordered collection of unique elements.
    /// * `Vector`: A specialized list that represents a fixed-size array of
    ///   elements. The vector dimension is determined by you. Must have elements
    ///   with fractional feature types.
    collection_type: ?CollectionType,

    /// The name of a feature. The type must be a string. `FeatureName` cannot be
    /// any of the following: `is_deleted`, `write_time`, `api_invocation_time`.
    ///
    /// The name:
    ///
    /// * Must start with an alphanumeric character.
    /// * Can only include alphanumeric characters, underscores, and hyphens. Spaces
    ///   are not allowed.
    feature_name: []const u8,

    /// The value type of a feature. Valid values are Integral, Fractional, or
    /// String.
    feature_type: FeatureType,

    pub const json_field_names = .{
        .collection_config = "CollectionConfig",
        .collection_type = "CollectionType",
        .feature_name = "FeatureName",
        .feature_type = "FeatureType",
    };
};
