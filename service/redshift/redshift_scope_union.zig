const Connect = @import("connect.zig").Connect;

/// A union structure that defines the scope of Amazon Redshift service
/// integrations. Contains configuration for different integration types such as
/// Amazon Redshift.
pub const RedshiftScopeUnion = union(enum) {
    /// The Amazon Redshift connect integration scope configuration. Defines
    /// authorization settings for Amazon Redshift connect service integration.
    connect: ?Connect,
};
