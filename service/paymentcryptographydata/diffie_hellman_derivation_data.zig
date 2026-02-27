/// The shared information used when deriving a key using ECDH.
pub const DiffieHellmanDerivationData = union(enum) {
    /// A string containing information that binds the ECDH derived key to the two
    /// parties involved or to the context of the key.
    ///
    /// It may include details like identities of the two parties deriving the key,
    /// context of the operation, session IDs, and optionally a nonce. It must not
    /// contain zero bytes. It is not recommended to reuse shared information for
    /// multiple ECDH key derivations, as it could result in derived key material
    /// being the same across different derivations.
    shared_information: ?[]const u8,

    pub const json_field_names = .{
        .shared_information = "SharedInformation",
    };
};
