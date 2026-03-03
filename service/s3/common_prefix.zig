/// Container for all (if there are any) keys between Prefix and the next
/// occurrence of the string
/// specified by a delimiter. CommonPrefixes lists keys that act like
/// subdirectories in the directory
/// specified by Prefix. For example, if the prefix is notes/ and the delimiter
/// is a slash (/) as in
/// notes/summer/july, the common prefix is notes/summer/.
pub const CommonPrefix = struct {
    /// Container for the specified common prefix.
    prefix: ?[]const u8 = null,
};
