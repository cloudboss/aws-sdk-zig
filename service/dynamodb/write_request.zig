const DeleteRequest = @import("delete_request.zig").DeleteRequest;
const PutRequest = @import("put_request.zig").PutRequest;

/// Represents an operation to perform - either `DeleteItem` or
/// `PutItem`. You can only request one of these operations, not both, in a
/// single `WriteRequest`. If you do need to perform both of these operations,
/// you need to provide two separate `WriteRequest` objects.
pub const WriteRequest = struct {
    /// A request to perform a `DeleteItem` operation.
    delete_request: ?DeleteRequest,

    /// A request to perform a `PutItem` operation.
    put_request: ?PutRequest,
};
