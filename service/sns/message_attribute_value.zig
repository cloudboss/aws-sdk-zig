/// The user-specified message attribute value. For string data types, the value
/// attribute
/// has the same restrictions on the content as the message body. For more
/// information, see
/// [Publish](https://docs.aws.amazon.com/sns/latest/api/API_Publish.html).
///
/// Name, type, and value must not be empty or null. In addition, the message
/// body should
/// not be empty or null. All parts of the message attribute, including name,
/// type, and
/// value, are included in the message size restriction, which is currently 256
/// KB (262,144
/// bytes). For more information, see [Amazon SNS message
/// attributes](https://docs.aws.amazon.com/sns/latest/dg/SNSMessageAttributes.html) and
/// [Publishing
/// to a mobile
/// phone](https://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html)
/// in the *Amazon SNS Developer Guide.*
pub const MessageAttributeValue = struct {
    /// Binary type attributes can store any binary data, for example, compressed
    /// data,
    /// encrypted data, or images.
    binary_value: ?[]const u8 = null,

    /// Amazon SNS supports the following logical data types: String, String.Array,
    /// Number, and
    /// Binary. For more information, see [Message
    /// Attribute Data
    /// Types](https://docs.aws.amazon.com/sns/latest/dg/SNSMessageAttributes.html#SNSMessageAttributes.DataTypes).
    data_type: []const u8,

    /// Strings are Unicode with UTF8 binary encoding. For a list of code values,
    /// see [ASCII Printable
    /// Characters](https://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters).
    string_value: ?[]const u8 = null,
};
