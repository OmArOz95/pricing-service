# ════════════════════════════════════════════════════════════
#  العملي الأول · وصفة البناء
#
#  املا الفراغات المرقّمة ①–⑤ · وكلها مشروحة بالهانداوت.
#
#  ⚠ لما تحفظه: الاسم  Dockerfile  — **بلا امتداد خالص**
#    على ويندوز: Save as type ← All Files
#    وفعّل  View ← File name extensions  وتأكّد بعينك.
#
#  وشيل أسطر التعليقات هاي أو خلّيها — ما بتأثّر.
# ════════════════════════════════════════════════════════════


# ① من وين بنبدأ؟ صورة أساس فيها لينكس وبايثون ٣.١١ · النسخة المخفّفة
FROM python:3.11-slim


# ② اعمل مستخدم · ورقمه لازم يكون اللي Hugging Face بتشغّل فيه
RUN useradd -m -u 1000 user
USER user


ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH
WORKDIR $HOME/app


# ③ انسخ المتطلّبات **لحالها** أول — وخلّيها ملك المستخدم
COPY --chown=user requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt


# ④ وهلأ انسخ باقي المشروع — وكمان ملك المستخدم
COPY --chown=user . .


# ⑤ المنفذ · والعنوان
#    انتبه للعنوان: في قيمة معناها «جوّا الحاوية بس»
#    وقيمة معناها «أي حدا من برّا». بدنا الثانية.
EXPOSE 0.0.0.0

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
