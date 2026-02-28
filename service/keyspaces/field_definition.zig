/// A field definition consists out of a name and a type.
pub const FieldDefinition = struct {
    /// The identifier.
    name: []const u8,

    /// Any supported Cassandra data type, including collections and other
    /// user-defined types that are contained in the same keyspace.
    ///
    /// For more information, see [Cassandra data type
    /// support](https://docs.aws.amazon.com/keyspaces/latest/devguide/cassandra-apis.html#cassandra-data-type) in the *Amazon Keyspaces Developer Guide*.
    @"type": []const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
