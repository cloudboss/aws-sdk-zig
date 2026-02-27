const ResourceLocation = @import("resource_location.zig").ResourceLocation;

/// Specifies the current source of the resource and the destination of where it
/// will be moved
/// to.
pub const ResourceMapping = struct {
    /// The destination stack `StackName` and `LogicalResourceId` for the
    /// resource being refactored.
    destination: ResourceLocation,

    /// The source stack `StackName` and `LogicalResourceId` for the resource
    /// being refactored.
    source: ResourceLocation,
};
