pub const Application = enum {
    microsoft_office_2016,
    microsoft_office_2019,

    pub const json_field_names = .{
        .microsoft_office_2016 = "Microsoft_Office_2016",
        .microsoft_office_2019 = "Microsoft_Office_2019",
    };
};
