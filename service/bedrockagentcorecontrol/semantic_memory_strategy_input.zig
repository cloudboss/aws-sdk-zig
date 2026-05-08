const MemoryRecordSchema = @import("memory_record_schema.zig").MemoryRecordSchema;

/// Input for creating a semantic memory strategy.
pub const SemanticMemoryStrategyInput = struct {
    /// The description of the semantic memory strategy.
    description: ?[]const u8 = null,

    memory_record_schema: ?MemoryRecordSchema = null,

    /// The name of the semantic memory strategy.
    name: []const u8,

    /// The namespaces associated with the semantic memory strategy.
    namespaces: ?[]const []const u8 = null,

    /// The namespaceTemplates associated with the semantic memory strategy.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .memory_record_schema = "memoryRecordSchema",
        .name = "name",
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
