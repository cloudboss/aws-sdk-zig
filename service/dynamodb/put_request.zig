/// Represents a request to perform a `PutItem` operation on an item.
pub const PutRequest = struct {
    /// A map of attribute name to attribute values, representing the primary key of
    /// an item
    /// to be processed by `PutItem`. All of the table's primary key attributes must
    /// be specified, and their data types must match those of the table's key
    /// schema. If any
    /// attributes are present in the item that are part of an index key schema for
    /// the table,
    /// their types must match the index key schema.
    item: []const u8,
};
