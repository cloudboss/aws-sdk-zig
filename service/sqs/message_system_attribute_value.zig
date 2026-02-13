/// The user-specified message system attribute value. For string data types,
/// the
/// `Value` attribute has the same restrictions on the content as the message
/// body. For more information, see `
/// SendMessage.`
///
/// `Name`, `type`, `value` and the message body must not
/// be empty or null.
pub const MessageSystemAttributeValue = struct {
    /// Not implemented. Reserved for future use.
    binary_list_values: ?[]const []const u8,

    /// Binary type attributes can store any binary data, such as compressed data,
    /// encrypted
    /// data, or images.
    binary_value: ?[]const u8,

    /// Amazon SQS supports the following logical data types: `String`,
    /// `Number`, and `Binary`. For the `Number` data type,
    /// you must use `StringValue`.
    ///
    /// You can also append custom labels. For more information, see [Amazon SQS
    /// Message
    /// Attributes](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-metadata.html#sqs-message-attributes) in the *Amazon SQS Developer
    /// Guide*.
    data_type: []const u8,

    /// Not implemented. Reserved for future use.
    string_list_values: ?[]const []const u8,

    /// Strings are Unicode with UTF-8 binary encoding. For a list of code values,
    /// see [ASCII Printable
    /// Characters](http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters).
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .binary_list_values = "BinaryListValues",
        .binary_value = "BinaryValue",
        .data_type = "DataType",
        .string_list_values = "StringListValues",
        .string_value = "StringValue",
    };
};
