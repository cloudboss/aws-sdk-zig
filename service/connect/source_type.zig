pub const SourceType = enum {
    salesforce,
    zendesk,
    cases,

    pub const json_field_names = .{
        .salesforce = "SALESFORCE",
        .zendesk = "ZENDESK",
        .cases = "CASES",
    };
};
