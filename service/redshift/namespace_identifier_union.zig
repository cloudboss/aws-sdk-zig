const ProvisionedIdentifier = @import("provisioned_identifier.zig").ProvisionedIdentifier;
const ServerlessIdentifier = @import("serverless_identifier.zig").ServerlessIdentifier;

/// Object to store union of values for a
/// provisioned cluster or serverless namespace’s identifier.
pub const NamespaceIdentifierUnion = union(enum) {
    /// The identifier for a provisioned cluster.
    provisioned_identifier: ?ProvisionedIdentifier,
    /// The identifier for a serverless namespace.
    serverless_identifier: ?ServerlessIdentifier,
};
