/// Describes an Electronic Data Interchange (EDI) entity as described in as
/// defined in [Subject Alternative
/// Name](https://datatracker.ietf.org/doc/html/rfc5280) in RFC 5280.
pub const EdiPartyName = struct {
    /// Specifies the name assigner.
    name_assigner: ?[]const u8,

    /// Specifies the party name.
    party_name: []const u8,

    pub const json_field_names = .{
        .name_assigner = "NameAssigner",
        .party_name = "PartyName",
    };
};
