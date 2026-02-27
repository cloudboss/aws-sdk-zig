const aws = @import("aws");

const DocumentAttributeBoostingConfiguration = @import("document_attribute_boosting_configuration.zig").DocumentAttributeBoostingConfiguration;

/// Configuration information for an Amazon Q Business index.
pub const NativeIndexConfiguration = struct {
    /// Overrides the default boosts applied by Amazon Q Business to supported
    /// document attribute data types.
    boosting_override: ?[]const aws.map.MapEntry(DocumentAttributeBoostingConfiguration),

    /// The identifier for the Amazon Q Business index.
    index_id: []const u8,

    /// A read-only field that specifies the version of the
    /// `NativeIndexConfiguration`.
    ///
    /// Amazon Q Business introduces enhanced document retrieval capabilities in
    /// version 2 of `NativeIndexConfiguration`, focusing on streamlined metadata
    /// boosting that prioritizes recency and source relevance to deliver more
    /// accurate responses to your queries. Version 2 has the following differences
    /// from version 1:
    ///
    /// * Version 2 supports a single Date field (created_at OR last_updated_at) for
    ///   recency boosting
    /// * Version 2 supports a single String field with an ordered list of up to 5
    ///   values
    /// * Version 2 introduces number-based boost levels (ONE, TWO) alongside the
    ///   text-based levels
    /// * Version 2 allows specifying prioritization between Date and String fields
    /// * Version 2 maintains backward compatibility with existing configurations
    version: ?i64,

    pub const json_field_names = .{
        .boosting_override = "boostingOverride",
        .index_id = "indexId",
        .version = "version",
    };
};
