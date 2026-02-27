pub const Framework = enum {
    hyperledger_fabric,
    ethereum,

    pub const json_field_names = .{
        .hyperledger_fabric = "HYPERLEDGER_FABRIC",
        .ethereum = "ETHEREUM",
    };
};
