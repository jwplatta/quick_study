# Quick Study

## Usage

```
$ rake new_review
$ rake build_json
$ rake review
```

## Notes
- `Scraper` will pull questions from a properly formatted markdown file and write them to an easy to parse json file:
From:
```
# Title

- Question 1

Answer 1

- Question 2

Answer 2
```

To:
```json
{
	"title": "chapter 2",
	"questions": [{
			"id": 1,
			"question_text": "foo",
			"answer_text": "bar",
			"info": "pg 123"
		},
		{
			"id": 2,
			"question_text": "wam",
			"answer_text": "bam",
			"info": "pg 456"
		}
	]
}
```

- Create new directory `/quick_study`
- `object = JSON.parse(json, object_class: OpenStruct)`