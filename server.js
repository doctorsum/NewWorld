const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 4000;

// تحديد مسار مجلد noVNC لتقديمه كواجهة ويب
const noVncPath = '/opt/noVNC';

// تقديم ملفات noVNC من المسار المحدد
app.use(express.static(noVncPath));

// إعادة توجيه أي طلب إلى ملف index.html الخاص بـ noVNC
app.get('*', (req, res) => {
  res.sendFile(path.join(noVncPath, 'index.html'));
});

app.listen(port, () => {
  console.log(`noVNC web interface listening on port ${port}`);
});
