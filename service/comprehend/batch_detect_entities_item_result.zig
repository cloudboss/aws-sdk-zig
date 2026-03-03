const Entity = @import("entity.zig").Entity;

/// The result of calling the operation. The
/// operation returns one object for each document that is successfully
/// processed by the
/// operation.
pub const BatchDetectEntitiesItemResult = struct {
    /// One or more Entity objects, one for each entity detected in the
    /// document.
    entities: ?[]const Entity = null,

    /// The zero-based index of the document in the input list.
    index: ?i32 = null,

    pub const json_field_names = .{
        .entities = "Entities",
        .index = "Index",
    };
};
