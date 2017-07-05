import os
import glob

from flask import Flask, render_template
app = Flask(__name__)


APP_ROOT = os.path.dirname(os.path.abspath(__file__))
APP_CLASSIFICATION = os.path.join(APP_ROOT, 'classification')


def get_most_recent_classification_files(limit):
    return sorted(glob.iglob(APP_CLASSIFICATION + '/*'), key=os.path.getctime, reverse = True)[:limit]


def convert_fuzzy_to_pretty_dict(line):
    components = map(lambda x: x.strip(), line.split("(score ="))
    return {
        "text": " ".join(components[:-1]),
        "prob_pretty": str(float(components[-1].strip(")"))*100) + "%",
        "prob": float(components[-1].strip(")"))
    }


def get_most_recent_records(limit):
    items = []
    newest = get_most_recent_classification_files(limit)
    for f in newest:
        records = map(lambda x: convert_fuzzy_to_pretty_dict(x), open(f, "r").readlines())
        items.append({"filename":  os.path.basename(f), "records": records})
    return items


@app.route("/")
def index():
    items = get_most_recent_records(10)
    return render_template('index.html', items=items)

app.run('0.0.0.0', 5000)
