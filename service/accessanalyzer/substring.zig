/// A reference to a substring of a literal string in a JSON document.
pub const Substring = struct {
    /// The length of the substring.
    length: i32,

    /// The start index of the substring, starting from 0.
    start: i32,

    pub const json_field_names = .{
        .length = "length",
        .start = "start",
    };
};
