/// Describes the user data for an instance.
pub const UserData = struct {
    /// The user data. If you are using an Amazon Web Services SDK or command line
    /// tool, Base64-encoding is performed for you, and you
    /// can load the text from a file. Otherwise, you must provide Base64-encoded
    /// text.
    data: ?[]const u8 = null,
};
