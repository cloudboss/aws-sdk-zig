pub const TrainedModelExportFileType = enum {
    model,
    output,

    pub const json_field_names = .{
        .model = "MODEL",
        .output = "OUTPUT",
    };
};
