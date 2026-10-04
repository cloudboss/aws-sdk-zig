/// An item to add to the domain as part of a batch request.
pub const BatchPutProfileObjectRequestItem = struct {
    /// A unique identifier for this item in the batch request. Used to correlate
    /// items in the response.
    id: []const u8,

    /// A string that is serialized from a JSON object.
    object: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .object = "Object",
    };
};
