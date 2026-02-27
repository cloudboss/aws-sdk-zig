/// The location of the custom terminology data.
pub const TerminologyDataLocation = struct {
    /// The Amazon S3 location of the most recent custom terminology input file that
    /// was
    /// successfully imported into Amazon Translate. The location is returned as a
    /// presigned URL that
    /// has a 30-minute expiration .
    ///
    /// Amazon Translate doesn't scan all input files for the risk of CSV injection
    /// attacks.
    ///
    /// CSV injection occurs when a .csv or .tsv file is altered so that a record
    /// contains
    /// malicious code. The record begins with a special character, such as =, +, -,
    /// or @. When the
    /// file is opened in a spreadsheet program, the program might interpret the
    /// record as a formula
    /// and run the code within it.
    ///
    /// Before you download an input file from Amazon S3, ensure that you recognize
    /// the file and trust its creator.
    location: []const u8,

    /// The repository type for the custom terminology data.
    repository_type: []const u8,

    pub const json_field_names = .{
        .location = "Location",
        .repository_type = "RepositoryType",
    };
};
