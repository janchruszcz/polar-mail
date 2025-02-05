# Polar-Mail

Polar-Mail is a Ruby on Rails application that helps users draft effective cold emails using AI. The application allows users to input their email requirements and generates personalized, professional cold emails using OpenAI's GPT models.

## Features

- Generate AI-powered cold emails with customized parameters
- Maintain history of generated emails
- Support for multiple languages and tones
- Adjustable reading time targets
- API endpoint for integration with other systems
- Responsive web interface
- Email history tracking

## Technical Stack

- Ruby 3.2+
- Rails 8
- PostgreSQL
- OpenAI API
- Tailwind CSS
- Minitest for testing

## Prerequisites

- Ruby 3.2 or higher
- PostgreSQL
- OpenAI API key

## Installation

1. Clone the repository:
```bash
git clone https://github.com/janchruszcz/polar-mail.git
cd polar-mail
```

2. Install dependencies:
```bash
bundle install
```

3. Set up environment variables:

Edit `.env` and add your OpenAI API key and other configuration values.

4. Set up the database:
```bash
rails db:create
rails db:migrate
```

5. Start the server:
```bash
bin/dev
```

The application will be available at `http://localhost:3000`

## Configuration

The following environment variables can be configured in your `.env` file:

```
OPENAI_API_KEY=your_openai_api_key_here
```

## Testing

Run the test suite:

```bash
rails test
```

The project uses Minitest for testing. Test files are located in the `test` directory.

## API Usage

The application provides a REST API endpoint for email generation:

```bash
POST /api/emails
Content-Type: application/json

{
  "email": {
    "purpose": "Business proposal",
    "recipient_info": "John Doe, CEO of Tech Corp",
    "sender_info": "Jane Smith, Sales Manager",
    "parameters": {
      "tone": "professional",
      "language": "en",
      "reading_time": "1 minute"
    }
  }
}
```

Response:
```json
{
  "id": 1,
  "subject": "Innovative Business Proposal for Tech Corp",
  "content": "Dear Mr. Doe,\n\n...",
  "created_at": "2025-02-05T12:00:00Z"
}
```

## Project Structure

```
app/
├── controllers/
│   ├── api/
│   │   └── emails_controller.rb
│   └── emails_controller.rb
├── models/
│   ├── email.rb
│   └── email_history.rb
├── services/
│   ├── ai/
│   │   └── openai_service.rb
│   └── email_generation/
│       └── generator.rb
└── views/
    └── emails/
        ├── index.html.erb
        ├── new.html.erb
        └── show.html.erb
```

## Key Features Implementation

### Email Generation
- Uses OpenAI's GPT model for content generation
- Implements prompt engineering for optimal results
- Maintains consistent tone and style
- Handles multiple languages

### Cold Email Best Practices
- Personalization based on recipient information
- Clear value proposition
- Appropriate call-to-action
- Professional tone
- Concise content

### History Tracking
- Maintains record of generated emails
- Tracks generation timestamps
- Allows reference to previous emails

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

- OpenAI for providing the GPT API
- Ruby on Rails community
- Tailwind CSS team

## Future Improvements

- Email generation in a background job
- Add rate limiting, request/prompt caching
- Add error handling
- Add email validation
- Add user authentication
- Upgrade test suite
- Refine UI/UX
- Implement email template management
- Add email effectiveness tracking
- Support for more language models
- Advanced customization options
- Email sequence automation
