pub const CustomVocabularyStatus = enum {
    ready,
    deleting,
    exporting,
    importing,
    creating,

    pub const json_field_names = .{
        .ready = "Ready",
        .deleting = "Deleting",
        .exporting = "Exporting",
        .importing = "Importing",
        .creating = "Creating",
    };
};
