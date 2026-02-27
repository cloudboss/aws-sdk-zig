pub const ActionOwner = enum {
    aws,
    third_party,
    custom,

    pub const json_field_names = .{
        .aws = "AWS",
        .third_party = "ThirdParty",
        .custom = "Custom",
    };
};
