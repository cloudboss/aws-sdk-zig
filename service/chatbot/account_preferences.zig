/// Preferences related to AWS Chatbot usage in the calling AWS account.
pub const AccountPreferences = struct {
    /// Turns on training data collection.
    ///
    /// This helps improve the AWS Chatbot experience by allowing AWS Chatbot to
    /// store and use your customer information, such as AWS Chatbot configurations,
    /// notifications, user inputs, AWS Chatbot generated responses, and interaction
    /// data. This data helps us to continuously improve and develop Artificial
    /// Intelligence (AI) technologies. Your data is not shared with any third
    /// parties and is protected using sophisticated controls to prevent
    /// unauthorized access and misuse. AWS Chatbot does not store or use
    /// interactions in chat channels with Amazon Q for training AI technologies for
    /// AWS Chatbot.
    training_data_collection_enabled: ?bool = null,

    /// Enables use of a user role requirement in your chat configuration.
    user_authorization_required: ?bool = null,

    pub const json_field_names = .{
        .training_data_collection_enabled = "TrainingDataCollectionEnabled",
        .user_authorization_required = "UserAuthorizationRequired",
    };
};
