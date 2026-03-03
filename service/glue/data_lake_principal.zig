/// The Lake Formation principal.
pub const DataLakePrincipal = struct {
    /// An identifier for the Lake Formation principal.
    data_lake_principal_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_lake_principal_identifier = "DataLakePrincipalIdentifier",
    };
};
